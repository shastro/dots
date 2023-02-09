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
    set -gx EDITOR hx
    set -gx SHELL fish

    abbr lf lfcd

end

set -g fish_greeting
