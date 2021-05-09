function updateShopUiInfo(data) {
  console.log(data);
  data.forEach((item) => {
    var newElement = document.createElement("li");
    newElement.id = item.name;
    newElement.className = "Item";
    newElement.innerHTML = item.name;
    newElement.onclick = addItem;
    document.getElementById("itemList").appendChild(newElement);
  });
}

function updateShopUiInfo(data) {
  data.forEach((item) => {
    const itemContainer = document.createElement("div");
    itemContainer.className = "buyItem"
    var newItem = document.createElement("li");
    newItem.id = item.iditem;
    newItem.className = "Item";
    newItem.innerHTML = item.iditem;
    const addButton = document.createElement("button")
    addButton.className="quantityButton btnAdd"
    addButton.innerHTML="+"
    const subsButton = document.createElement("button")
    const quantity = document.createElement("div");
    quantity.className = "quantity"
    quantity.innerHTML = "0"
    subsButton.className="quantityButton btnSubs"
    subsButton.innerHTML="-"

    itemContainer.appendChild(newItem)
    itemContainer.appendChild(addButton)
    itemContainer.appendChild(quantity)
    itemContainer.appendChild(subsButton)

    document.getElementById("buyList").appendChild(itemContainer)
  });
}

// This is the close event
$(".close").click(function () {
  $("#shopCreatorUi").hide();
  $("#shopUi").hide();

  $.post("http://soli_shops/exit", JSON.stringify({}));
});