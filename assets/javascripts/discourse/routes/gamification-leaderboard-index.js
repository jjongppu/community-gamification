import { service } from "@ember/service";
import { ajax } from "discourse/lib/ajax";
import DiscourseRoute from "discourse/routes/discourse";

export default class GamificationLeaderboardIndex extends DiscourseRoute {
  @service router;

  model() {
    return ajax(`/point_rank`)
      .then((response) => {
        return response;
      })
      .catch(() => this.router.replaceWith("/404"));
  }
}
