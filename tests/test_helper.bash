HOST_NAME=microbuntu
BASE_USER=ubuntu

vagrant_ssh() {
    vagrant ssh -c "${*}" -- -n -T
}
