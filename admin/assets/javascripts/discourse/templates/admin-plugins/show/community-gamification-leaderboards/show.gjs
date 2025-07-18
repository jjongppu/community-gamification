import RouteTemplate from "ember-route-template";
import AdminEditLeaderboard from "discourse/plugins/community-gamification/admin/components/admin-edit-leaderboard";

export default RouteTemplate(
  <template>
    <div class="admin-detail">
      <AdminEditLeaderboard @leaderboard={{@model}} />
    </div>
  </template>
);
