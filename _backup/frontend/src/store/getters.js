// https://vuex.vuejs.org/en/getters.html

// Vuex allows us to define "getters" in the store.
// You can think of them as computed properties for stores.
// Like computed properties, a getter's result is cached based on its dependencies,
// and will only re-evaluate when some of its dependencies have changed.

export default {

  lang: state => {

    if (state.app_info.lang == undefined || state.app_info.lang == null || state.app_info.lang == '') {
      let local_lang = localStorage.getItem('alphacar_lang');
      let lang = 'en'
      if (local_lang != undefined && local_lang != "") {
        lang = local_lang;
      }
      return lang;
    }

    return state.app_info.lang;
  },

};
