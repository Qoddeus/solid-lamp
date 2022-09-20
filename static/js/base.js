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

// TOGGLE SIDEMENU
const sidemenu = document.getElementById("menu-item");
function toggle_sidemenu() { sidemenu.classList.toggle("active"); }

// SHOW LOGIN FORM
const login = document.querySelector(".popup-login");
const close_login = document.querySelector(".popup-login .close-login");
close_login.addEventListener("click", () => { login.classList.remove("active"); login.close(); })

// SHOW DASH FORMS
const product = document.querySelector(".add-product");
const open_product = document.querySelector("#open-product");
const close_product = document.querySelector(".close-product");
open_product.addEventListener("click", () => { product.classList.add("active"); })
close_product.addEventListener("click", () => { product.classList.remove("active"); })

// DISABLE ESC KEY for modal, but I think it includes all
window.onkeydown = function(e) { if(e.keyCode === 27) { e.preventDefault(); }};

// CLOSE FLASH BY CLICKING
function close_flash() {
	var flash = document.getElementById("flash-messages");
	if (flash.style.display === "none") { flash.style.display = "block"; }
	else { flash.style.display = "none"; }
}