function search(element) {
    const form = element.closest(".form-search")
    const textField = form.querySelector(".input-search")
    const button = form.querySelector(".btn-search")
    const text = textField.value
    if(text.length > 0) {
        window.location = "/search?q="+text
    }
    else {
        // Add a class that defines an animation
        form.classList.add('input-error');
          
        // remove the class after the animation completes
        setTimeout(function() {
            form.classList.remove('input-error');
        }, 300);
    }

}

document.querySelector('.input-search').addEventListener('keypress', function (e) {
    if (e.key === 'Enter') {
        search(e.target)
    }
});

document.querySelector('.btn-search').addEventListener('click', function (e) {
    search(e.target)
});