//sắp xếp sản phẩm
const lisSort = document.querySelectorAll(".sort-product");
lisSort.forEach((li, index) => {
  li.addEventListener("click", () => {
    //xóa class của tất cả các thẻ li
    lisSort.forEach((liFilter) => {
      liFilter.classList.remove("active-red");
    });

    //thêm class cho thẻ li tương ứng với thẻ li được click
    li.classList.add("active-red");
  });

  li.addEventListener("dblclick", () => {
    lisSort[index].classList.remove("active-red");
  });
});

//thương hiệu sản phẩm
const lisTra = document.querySelectorAll(".trademark-product");
lisTra.forEach((li, index) => {
  li.addEventListener("click", () => {
    //xóa class của tất cả các thẻ li
    lisTra.forEach((liFilter) => {
      liFilter.classList.remove("active-red");
    });

    //thêm class cho thẻ li tương ứng với thẻ li được click
    li.classList.add("active-red");
  });

  li.addEventListener("dblclick", () => {
    lisTra[index].classList.remove("active-red");
  });
});
