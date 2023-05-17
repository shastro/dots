if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx PATH $PATH ~/bin
    set -gx PATH $PATH ~/scripts
    set -gx PATH $PATH /usr/local/go/bin
    set -gx PATH $PATH ~/.cargo/bin
    set -gx PATH $PATH ~/installdump/arduino-language-server
    if [ "$TERM" = "xterm-kitty" ]
        export TERM=xterm
    end
    abbr --set lf lfcd
    set -gx EDITOR hx
    set -gx SHELL fish

    set -gx LIBVA_DRIVER_NAME vdpau

    set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket.
end

set -g fish_greeting

starship init fish | source

