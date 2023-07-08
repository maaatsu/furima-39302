document.addEventListener("DOMContentLoaded", () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value, 10);
    const tax = Math.floor(price * 0.1);
    const profitAmount = Math.floor(price - tax);

    if (isNaN(price)) {
      addTaxPrice.textContent = "0";
      profit.textContent = "0";
    } else {
      addTaxPrice.textContent = tax.toLocaleString();
      profit.textContent = profitAmount.toLocaleString();
    }
  });
});
