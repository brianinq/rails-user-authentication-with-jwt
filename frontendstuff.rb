fetch("http://localhost:3000/api/v1/users", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
  body: JSON.stringify(newUserData),
})
  .then((r) => r.json())
  .then((data) => {
    // save the token to localStorage for future access
    localStorage.setItem("jwt", data.jwt);
    // save the user somewhere (in state!) to log the user in
    setUser(data.user);
  });


  #//post login requests
  const token = localStorage.getItem("jwt");

fetch("http://localhost:3000/api/v1/profile", {
  method: "GET",
  headers: {
    Authorization: `Bearer ${token}`,
  },
});