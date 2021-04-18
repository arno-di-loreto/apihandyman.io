function search(element) {
    const form = element.closest(".form-search")
    const textField = form.querySelector(".input-search")
    const button = form.querySelector(".btn-search")
    const text = textField.value
    window.location = "/search?q="+text
}

document.querySelector('.input-search').addEventListener('keypress', function (e) {
    if (e.key === 'Enter') {
        search(e.target)
    }
});

document.querySelector('.btn-search').addEventListener('click', function (e) {
    search(e.target)
});