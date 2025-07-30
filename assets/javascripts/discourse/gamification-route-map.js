export default function () {
  this.route("gamificationLeaderboard", { path: "/point_rank" }, function () {
    this.route("byName", { path: "/:leaderboardId" });
  });
}
