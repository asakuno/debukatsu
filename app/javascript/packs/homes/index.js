const fetchFoods = async () => {
  try {
    const response = await fetch("/api/foods/");
    const data = await response.json();
    const MENUS = data.foods.map((food) => {
      return {
        id: food.id,
        name: food.name,
        calorie: food.calorie,
        price: food.price,
      };
    });
    console.log(MENUS);
    return MENUS;
  } catch {
    const message = "エラーが発生しました。";
    alert(message);
    throw new Error(message);
  }
};

const result = document.getElementById("result");
const runGachaBtn = document.getElementById("runGachaBtn");
const budgetInput = document.getElementById("budget");

const runGacha = async () => {
  try {
    const MENUS = await fetchFoods();
    let budget = parseInt(budgetInput.value);
    let totalPrice = 0;
    let totalCalorie = 0;

    while (budget >= 0) {
      var rand2 = Math.floor(Math.random() * MENUS.length);
      var food = MENUS[rand2];
      if (budget - food.price < 0) {
        break;
      }
      result.innerHTML +=
        '<div class="my-4 border-l-6 border-yellow-100 shadow-md py-2 px-4 bg-yellow-50"><h2 class="text-red-600 text-lg my-0 py-0">' +
        food.name +
        '</h2><p class="text-center">' +
        food.price +
        '円  ' +
        food.calorie +
        'kcal</p></div>';
      totalPrice += food.price;
      totalCalorie += food.calorie;
      budget -= food.price;
    }

    result.innerHTML +=
      '<div class="my-4 border-l-6 border-yellow-700 shadow-md p-4 bg-yellow-400 bg-opacity-30"><h2 class="text-red-600 text-lg my-0 py-0">合計: ' +
      totalPrice +
      '円   ' +
      totalCalorie +
      'kcal</h2></div>';
  } catch (error) {
    console.error(error);
  }
};

runGachaBtn.addEventListener("click", () => {
  result.innerHTML = "";
  runGacha();
});

const calorie_result = document.getElementById("calorie-result");
const runCalorieGachaBtn = document.getElementById("runCalorieGachaBtn");
const calorieInput = document.getElementById("input-calorie");

const runCalorieGacha = async () => {
  try {
    const MENUS = await fetchFoods();
    let calorie = parseInt(calorieInput.value);
    let totalPrice = 0;
    let totalCalorie = 0;

    while (calorie >= 0) {
      var rand2 = Math.floor(Math.random() * MENUS.length);
      var food = MENUS[rand2];
      if (calorie - food.calorie < 0) {
        break;
      }
      calorie_result.innerHTML +=
        '<div class="my-4 border-l-6 border-yellow-100 shadow-md py-2 px-4 bg-yellow-50"><h2 class="text-red-600 text-lg my-0 py-0">' +
        food.name +
        '</h2><p class="text-center">' +
        food.calorie +
        'kcal  ' +
        food.price +
        '円</p></div>';
      totalPrice += food.price;
      totalCalorie += food.calorie;
      calorie -= food.calorie;
    }

    calorie_result.innerHTML +=
      '<div class="my-4 border-l-6 border-yellow-700 shadow-md p-4 bg-yellow-400 bg-opacity-30"><h2 class="text-red-600 text-lg my-0 py-0">合計: ' +
      totalCalorie +
      'kcal   ' +
      totalPrice +
      '円</h2></div>';
  } catch (error) {
    console.error(error);
  }
};

runCalorieGachaBtn.addEventListener("click", () => {
  calorie_result.innerHTML = "";
  runCalorieGacha();
});