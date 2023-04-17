document.addEventListener("DOMContentLoaded", () => {
  const BASE_URL = "http://localhost:3000";

  const dashboard = document.getElementById("dashboard");
  const logout = document.getElementById("logout");

  const token = sessionStorage.getItem("acid_token");
  const userData = JSON.parse(sessionStorage.getItem("acid_user"));

  if (token) {
    fetch(`${BASE_URL}/dashboard`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(userData),
    })
      .then((res) => res.json())
      .then((result) => {
        if (result.successful) {
          dashboard.innerHTML = `
                <h1>Welcome ${user.name}</h1>
                <p>Email: ${user.email}</p>
            `;
        } else {
          alert(result.message);
        }
      });
  } else {
    window.location.replace("index.html");
  }

  logout.addEventListener("click", function (e) {
    e.preventDefault();
    sessionStorage.clear();
    window.location.replace("index.html");
  });
});
