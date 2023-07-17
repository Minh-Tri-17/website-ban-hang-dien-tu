//hiện thị toàn bộ thông số kỹ thuật
const infoProduct = document.querySelector(".info-product ");
const idMoreInfoProduct = document.querySelector("#more-info-product");
const hiddenInfoProduct = document.querySelector(
  ".info-product div:nth-child(1) i"
);

const backgroundBlack = document.querySelector(".background-black");
const displayBody = document.querySelector("body");

idMoreInfoProduct.addEventListener("click", () => {
  infoProduct.classList.remove("hidden");
  backgroundBlack.style.display = "block";
  displayBody.style.pointerEvents = "none";
  displayBody.style.overflow = "hidden";
  infoProduct.style.pointerEvents = "visible";
});

hiddenInfoProduct.addEventListener("click", () => {
  infoProduct.classList.add("hidden");
  backgroundBlack.style.display = "none";
  displayBody.style.pointerEvents = "visible";
  displayBody.style.overflow = "visible";
});

//tăng độ dài blog
const idMoreBlog = document.querySelector("#more-blog");
const classMoreBlog = document.querySelector(".more-blog");
const ProductBlog = document.querySelector(".product-blog");

idMoreBlog.addEventListener("click", () => {
  ProductBlog.style.height = "max-content";
  classMoreBlog.style.visibility = "hidden";
  idMoreBlog.style.visibility = "hidden";
});

//tô đỏ đánh giá
const star5 = document.querySelector(
  ".scores-right div:first-child > p:nth-child(4)"
);
const red = document.querySelector(".scores-right div:first-child > div");
if (star5.textContent != "0") {
  red.style.backgroundColor = "var(--red)";
}
