function post (){
  const svgElement = document.querySelector(".map-container svg");
  if (!svgElement) {
    console.error("SVG element not found");
    return;
  }

  const visitedPrefectures = window.visitedPrefectures || [];
  visitedPrefectures.forEach(id => {
    const prefectureElement = document.getElementById(`prefecture-${id}`);
    if (prefectureElement) {
      prefectureElement.style.fill = "#2ABA6C"; // 訪問済みの県を青色にする
    } else {
      console.warn(`Element not found for prefecture-${id}`);
    }
  });
};

window.addEventListener('turbo:load', post);
