export default {
  mounted() {
    let { to } = this.el.dataset;

    this.el.addEventListener("click", (ev) => {
      ev.preventDefault();
      console.log("CopyRow Clicked!")
      let text = document.querySelector(to).value
      navigator.clipboard.writeText(text).then(() => {})
    });
  },
};