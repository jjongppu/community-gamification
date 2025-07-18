import Component from "@ember/component";
import { classNames, tagName } from "@ember-decorators/component";
import { computed } from "@ember/object";

@tagName("div")
@classNames("user-card-metadata-outlet", "gamification-score")
export default class GamificationLevelDisplay extends Component {
  @computed("user.gamification_level_info")
  get levelBarStyle() {
    const info = this.user?.gamification_level_info;
    if (!info) return "width: 0%";
    return `width: ${info.progress_percent}%; background: #f8c100;`;
  }

  @computed("user.gamification_level_info.progress_percent")
  get levelProgressPercent() {
    const percent = this.user?.gamification_level_info?.progress_percent;
    return percent ? Math.floor(percent) : 0;
  }

  <template>
    {{#if this.user.gamification_level_info}}

      <div class="level-info-box">
        <div class="level-icon">
          <img src={{this.user.gamification_level_info.image_url}} />
        </div>

        <div class="user-level-bar">
          
          <div class="level-label">
            <div> {{this.user.gamification_level_info.name}} LV.{{this.user.gamification_level_info.level}} {{this.levelProgressPercent}}% 
            </div>
            <div>포인트 <span style="font-weight: bold;">{{this.user.gamification_level_info.current_score}}</span></div>
            
          </div>
          <div class="level-bar-outer">
            <div class="level-bar-inner" style={{this.levelBarStyle}}></div>
          </div>
        </div>
      </div>
    {{/if}}
  </template>
}
