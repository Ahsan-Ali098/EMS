document.addEventListener('turbolinks:load', () => {
  function addSignUp() {
    document.getElementsByClassName('sign-up-form')[0].classList.remove('d-none')
  }
  document.getElementsByClassName('sign-up-button')[0].addEventListener('click', addSignUp)
})
