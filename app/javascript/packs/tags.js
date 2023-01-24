$(document).on('turbolinks:load', function() {
  // id="app"のタグにあるdata-tag-list, data-my-tag-listの情報をjQueryで取得しています。
  // _form.html.erbでは、"tag_list"とアンダースコアで記載していますが、htmlではハイフン表示になります。
  const tagList = $("#app").data("tag-list");
  const myTagList = $("#app").data("my-tag-list");

  Vue.component('multiselect', window.VueMultiselect.default)
  // Vueコンポーネントのmultiselectを使用
  new Vue({
    el: "#app",
    data() {
      return {
        tagList: tagList,
        myTagList: myTagList,
      }
    },
    methods: {
      // 新規のタグを、"tagList"及び"myTagList"に追加するメソッドを定義しています。
      // このメソッドがなくても、既存のタグは登録できます。新規のタグを生成したい場合は必要となります。
      addTag(newTag) {
        this.tagList.push(newTag)
        this.myTagList.push(newTag)
      },
      alertRemove () {
        alert('タグを取り消しました');
      }
    },
  })
});