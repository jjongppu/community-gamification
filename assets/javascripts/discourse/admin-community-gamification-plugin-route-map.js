export default {
  resource: "admin.adminPlugins.show",

  path: "/plugins",

  map() {
    this.route(
      "community-gamification-leaderboards",
      { path: "leaderboards" },
      function () {
        this.route("show", { path: "/:id" });
      }
    );
  },
};
