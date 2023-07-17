//chuyển hiện thị giữa giỏ hàng và thông tin khách hàng
const btnOrder = document.querySelector("#order");
const classStep = document.querySelectorAll(
  ".product-order article:first-child div"
);

btnOrder.addEventListener("click", () => {
    classStep.style.color = "red";
});
