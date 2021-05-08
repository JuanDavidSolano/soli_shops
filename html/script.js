$(function () {
  window.addEventListener("message", function (event) {
    if (event.data.type === "creator") {
      $("#shopCreatorUi").fadeTo(10, 1.0);
    } else if (event.data.type === "exit") {
      $("#shopCreatorUi").fadeTo(10, 0.0);
      clearItemList();
    } else if (event.data.type === "updateItemList") {
      updateItemList(event.data.data);
    }
  });
});

// This is the item list search input function
$(document).ready(function () {
  $("#searchItemList").on("keyup", function () {
    var value = $(this).val().toLowerCase();
    $("#itemList li").filter(function () {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
});

// This is the shop list search input function
$(document).ready(function () {
  $("#searchShopList").on("keyup", function () {
    var value = $(this).val().toLowerCase();
    $("#shopList div").filter(function () {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
  });
});

// This is the close event
$(".close").click(function () {
  $("#shopCreatorUi").hide();
  $.post("http://soli_shops/exit", JSON.stringify({}));
});

// This is the cancel event
$(".cancel").click(function () {
  $("#shopCreatorUi").hide();
  $.post("http://soli_shops/exit", JSON.stringify({}));
});

// This is the creation event
$(".create").click(function(){
  createShop();
})

// Update the Item List in the UI from the DataBase
function updateItemList(data) {
  data.forEach((item) => {
    var newElement = document.createElement("li");
    newElement.id = item.name;
    newElement.className = "Item";
    newElement.innerHTML = item.name;
    newElement.onclick = addItem;
    document.getElementById("itemList").appendChild(newElement);
  });
}

function clearItemList() {
  $("#itemList li").remove();
  $("#searchItemList").val("");
  $("#shopList div").remove();
  $("#searchShopList").val("");
  $("#shopName").val("")
}

function addItem() {
  const item = document.getElementById(this.id);
  item.onclick = removeItem;
  $(`#${this.id}`).remove();
  const elementContainer = document.createElement("div");
  elementContainer.className = "shopItem";

  const buyInput = document.createElement("input");
  buyInput.className = "shopInput";
  const sellInput = document.createElement("input");
  sellInput.className = "shopInput";
  const amountInput = document.createElement("input");
  amountInput.className = "shopInput";

  elementContainer.appendChild(item);
  elementContainer.appendChild(buyInput);
  elementContainer.appendChild(sellInput);
  elementContainer.appendChild(amountInput);

  document.getElementById("shopList").appendChild(elementContainer);
}

function removeItem() {
  const item = document.getElementById(this.id);
  item.onclick = addItem;
  $(`#${this.id}`).parent().remove();
  document.getElementById("itemList").appendChild(item);
}

function createShop() {
  const shopName = $('#shopName').val();
  if(shopName != ""){
    $.post("http://soli_shops/create", JSON.stringify({name:shopName}));
  }
/*   $('#shopList li').each(function(i){
    console.log($(this).attr("id"))
  }) */
}
