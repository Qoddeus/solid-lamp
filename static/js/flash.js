function close_flash() {
	var flash = document.getElementById("flash-messages");
	if (flash.style.display === "none") { flash.style.display = "block"; }
	else { flash.style.display = "none"; }
}