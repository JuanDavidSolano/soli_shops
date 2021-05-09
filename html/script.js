$(function () {
  window.addEventListener("message", function (event) {
    if (event.data.type === "creator") {
      openShopCreator();
    } else if (event.data.type === "exit") {
      $("#shopCreatorUi").fadeTo(10, 0.0);
      clearItemList();
    } else if (event.data.type === "updateItemList") {
      updateItemList(event.data.data);
    } else if (event.data.type === "shop") {
      openShop();
    } else if (event.data.type === "updateShopUiInfo"){
      updateShopUiInfo(event.data.data);
    }
  });
});

function openShopCreator() {
  $("body").children().hide();
  $("body").load("./shop_creator/index.html");
  $("#shopCreatorUi").show();
}

function openShop() {
  $("body").children().hide();
  $("body").load("./shop_ui/index.html");
  $("#shopCreatorUi").show();
}
