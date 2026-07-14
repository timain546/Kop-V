function togglemdp() {
    var mdpInput = document.getElementById("mdp");
    console.log("clique");
    if (mdpInput.type === "password") {
        mdpInput.type = "text";
        document.getElementById("togglePassword").textContent = "⦵";
    } else {
        mdpInput.type = "password";
        document.getElementById("togglePassword").textContent = "☉";
    }
}