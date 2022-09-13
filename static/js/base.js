// TOGGLE SIDEBAR
const toggle = document.getElementById("sidebar-toggle");
const sidebar = document.getElementById("sidebar")
const main = document.getElementById("main");
const footer = document.getElementById("footer");

function toggle_sidebar() {
	toggle.classList.toggle("active");
	sidebar.classList.toggle("active");
	main.classList.toggle("active");
	footer.classList.toggle("active");
}

// TOGGLE LOGIN FORM
const login = document.querySelector(".popup-login");
const open_login = document.querySelector("#open-login");
const close_login = document.querySelector(".popup-login .close-button");

open_login.addEventListener("click", () => {
	login.classList.add("active");
	login.showModal();
})

close_login.addEventListener("click", () => {
	login.classList.remove("active");
	login.close();
})

// DISABLE ESC KEY for modal, but I think it includes all
window.onkeydown = function(e) { if(e.keyCode === 27) { e.preventDefault(); }};