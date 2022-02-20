(use-modules
 (gnu)
 (gnu system nss)
 (gnu services sddm)
 (srfi srfi-1)

 (nongnu packages linux)
 (nongnu system linux-initrd)
 )
(use-service-modules networking ssh)
(use-service-modules desktop xorg)
(use-package-modules certs gnome)
(use-service-modules nix)
(use-package-modules package-management)
;; (use-package-modules wm)  ;; for swaylock

(operating-system

 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))

 (host-name "guix")
 (timezone "Asia/Tokyo")
 (locale "en_US.utf8")

 (sudoers-file
  (plain-file "sudoers"
	      (string-append (plain-file-content %sudoers-specification)
			     "yasu ALL = NOPASSWD: ALL\n")))

 (keyboard-layout (keyboard-layout "us"))

 (bootloader (bootloader-configuration
	      (bootloader grub-efi-bootloader)
	      (targets (list "/boot/efi"))
	      (keyboard-layout keyboard-layout)))

 (file-systems (append
		(list (file-system
		       (device (file-system-label "my-root"))
		       (mount-point "/")
		       (type "ext4")
		       )
		      (file-system
		       (device (uuid "C2D0-0B91" 'fat))
		       (mount-point "/boot/efi")
		       (type "vfat")))
		%base-file-systems))
 (swap-devices (list 
		 (swap-space
		 (priority 50)
		 (target "/dev/nvme0n1p3"))))

 (users (cons (user-account
	       (name "yasu")
	       (comment "yasu")
	       (group "users")
	       (supplementary-groups '("wheel" "netdev"
				       "audio" "video")))
	      %base-user-accounts))

 (packages (append (list
		    ;;nix
		    ;; for HTTPS access
		    nss-certs
		    ;; for user mounts
		    gvfs
			;; swaylock ;; swaylock didn't work with gnome!
			)
		   %base-packages))

 (services (cons*
        ;; (screen-locker-service swaylock "swaylock")
		;; (service gnome-keyring-service-type)
	    (service openssh-service-type
		     (openssh-configuration
		      (x11-forwarding? #t)
		      (permit-root-login 'prohibit-password)
		      (password-authentication? #f)
		      (authorized-keys
		       `(("yasu" ,
			  (local-file "/home/yasu/.ssh/id_rsa.pub") ,
			  (local-file "iphone-yasu.pub")
			  )
			 ))))
	    (service gnome-desktop-service-type)
					;(service mate-desktop-service-type)
					;(service xfce-desktop-service-type)
	    (service sddm-service-type
		     (sddm-configuration
		      (display-server "wayland")
		      (remember-last-user? #t)
		      ))
					;(service nix-service-type)

	    (modify-services
	     (remove (lambda (service)
		       (member (service-kind service)
			       (list gdm-service-type)))
		     %desktop-services) ;end of remove lambda services

	     )	;;end of modify-services
	    ))	;;end of services

 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
