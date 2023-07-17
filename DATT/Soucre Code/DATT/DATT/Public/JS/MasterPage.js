//lấy chi nhánh theo click
const branchPosition = document.querySelectorAll(".list-branch li p");
const branchMain = document.getElementById("branch-main");
branchPosition.forEach((bra) => {
  bra.addEventListener("click", () => {
    branchMain.innerText = bra.textContent;
  });
});

//header
const header = document.querySelector("header");
//tạo sự kiện scroll
window.addEventListener("scroll", function () {
  //vị tri của y tính theo scroll y của hearder
  y = this.window.pageYOffset;
  if (y > 0) {
    header.classList.add("sticky");
  } else {
    header.classList.remove("sticky");
  }
  //vị tri của y tính theo scroll y của button đầu trang
  if (y < 550) {
    scrolltop.classList.add("hidden");
  } else {
    scrolltop.classList.remove("hidden");
  }
});

//lên đầu trang
const scrolltop = document.getElementById("scroll-top");
if (this.window.pageYOffset < 50) {
  scrolltop.classList.add("hidden");
}

scrolltop.addEventListener("click", () => {
  window.scrollTo({
    top: 0,
    behavior: "smooth",
  });
});
