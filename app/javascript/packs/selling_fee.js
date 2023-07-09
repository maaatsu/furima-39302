document.addEventListener("DOMContentLoaded", () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  const updateFeeAndProfit = () => {
    const price = parseInt(priceInput.value, 10);

    if (isNaN(price)) {
      addTaxPrice.textContent = "0";
      profit.textContent = "0";
    } else {
      const tax = Math.floor(price * 0.1);
      const profitAmount = Math.floor(price - tax);
      addTaxPrice.textContent = tax.toLocaleString();
      profit.textContent = profitAmount.toLocaleString();
    }
  };

  priceInput.addEventListener("input", updateFeeAndProfit);
  updateFeeAndProfit(); // 初期表示時にも計算する
});
