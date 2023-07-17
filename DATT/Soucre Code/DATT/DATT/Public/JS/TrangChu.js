// slides
const imgPosition = document.querySelectorAll(".slide-container img");
const imContainer = document.querySelector(".slide-container");
const dotItem = document.querySelectorAll(".dot");
let imNumber = imgPosition.length;
let index = 0;
//lặp qua từng thẻ img
imgPosition.forEach((image, index) => {
  image.style.left = index * 100 + "%";
  //tạo sự kiện click cho từng dot tương ứng
  dotItem[index].addEventListener("click", () => {
    slider(index);
  });
});

function imgSlide() {
  index++;
  if (index >= imNumber) {
    index = 0;
  }
  slider(index);
}

function slider(index) {
  imContainer.style.left = "-" + index * 100 + "%";
  const dotActive = document.querySelector(".active");
  //xóa tất cả các class active của class dot
  dotActive.classList.remove("active");
  //thêm class active cho dot tương úng
  dotItem[index].classList.add("active");
}
setInterval(imgSlide, 3000);

//click logo menu
const clickLogoMenu = document.querySelector("#logo-menu");
const menu = document.querySelector("nav");

menu.style.display = "block";
clickLogoMenu.addEventListener("click", () => {
  if (menu.style.display == "none") {
    menu.style.display = "block";
  } else {
    menu.style.display = "none";
  }
});

//loading
const loader = document.getElementById("loading")

function loading() {
    loader.style.display = "none";
}
