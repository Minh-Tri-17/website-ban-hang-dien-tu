//xử lý menu
const menu = document.querySelectorAll("nav > menu > a");
const title = document.querySelector("header > h2");

menu.forEach((menuIndex) => {
  menuIndex.addEventListener("click", () => {
    title.textContent = menuIndex.textContent;
  });
});

//lấy ngày giờ
const getDate = document.querySelector("header > h2:last-child");

function time() {
  var date = new Date();
  var second = date.getSeconds();
  var minute = date.getMinutes();
  var hour = date.getHours();
  var day = date.getDate();
  var month = date.getMonth() + 1;
  var year = date.getFullYear();

  getDate.textContent =
    hour +
    ":" +
    minute +
    ":" +
    second +
    " " +
    " - " +
    day +
    "/" +
    month +
    "/" +
    year;
}

setInterval(time, 1000);

