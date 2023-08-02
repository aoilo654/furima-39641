const priceInput = document.getElementById("item-price");
window.addEventListener('input', () => {
  const inputValue = priceInput.value;
  const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue / 10);
  const profitDom = document.getElementById("profit");
    profitDom.innerHTML = Math.floor(inputValue - (inputValue / 10));
});