(cons*
  (channel
    (name 'guix)
    (url "https://github.com/guix-mirror/guix.git")
    ;(commit "9b8839099e6c4447ad7c94451817f38f467f1e8f");;before removal of openssl1, needed for pantherx
    )

  ;(channel  ; needed to install vscode, requires openssl1 to be present in guix channel
  ;  (name 'pantherx)
  ;  (url "https://channels.pantherx.org/git/pantherx-extra.git")
  ;  (branch "rolling")
  ;  )
  (channel ; this is included as a submodule of PantherX
           (name 'nonguix)
           (url "https://gitlab.com/nonguix/nonguix")
           ;; Enable signature verification:
           (introduction
             (make-channel-introduction
               "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
               (openpgp-fingerprint
                 "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))

  (channel
    (name 'low-standard-guix)
    (url "https://github.com/yugawara/low-standard-guix.git")
    (branch "master"))


  %default-channels)
