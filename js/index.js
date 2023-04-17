document.addEventListener("DOMContentLoaded", () => {
  const BASE_URL = "http://localhost:3000";

  const loginForm = document.getElementById("loginForm");

  loginForm.addEventListener("submit", function (e) {
    e.preventDefault();

    const loginData = {
      email: loginForm["email"].value,
      password: loginForm["password"].value,
    };

    fetch(`${BASE_URL}/login`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(loginData),
    })
      .then((res) => res.json())
      .then((result) => {
        if (result.successful) {
          sessionStorage.setItem("acid_token", atob(result));
          sessionStorage.setItem("acid_user", JSON.stringify(result.data));
          window.location.replace("dashboard.html");
        } else {
          alert(result.message);
        }
      });
  });
});
