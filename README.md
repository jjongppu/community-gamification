# **Community Gamification** Plugin

# User Card
<img width="585" alt="Screen Shot 2022-03-18 at 9 33 24 AM" src="https://user-images.githubusercontent.com/50783505/159036553-b162f5b7-5acd-4134-ba5f-fa8dbb7f8f8f.png">

# User Metadata
<img width="1129" alt="Screen Shot 2022-03-18 at 10 48 25 AM" src="https://user-images.githubusercontent.com/50783505/159036559-15eff295-47f6-4294-bc4d-8ea4452b6d60.png">

# Directory
<img width="1106" alt="Screen Shot 2022-03-18 at 10 48 54 AM" src="https://user-images.githubusercontent.com/50783505/159036563-d866a819-e9c4-4c92-a415-1d51f5fe6d1a.png">

## Customizing Score Values

The number of points awarded for each action can be changed in the
**Admin &rarr; Settings &rarr; Plugins** panel. Look under the
**Score value settings** section and adjust the options that end with
`_score_value` to modify how many points a user receives for a given action.

Default score settings include:

| Setting | Default |
| ------- | ------- |
| `like_received_score_value` | 1 |
| `like_given_score_value` | 1 |
| `solution_score_value` | 5 |
| `solution_topic_score_value` | 2 |
| `user_invited_score_value` | 10 |
| `time_read_score_value` | 1 |
| `post_read_score_value` | 1 |
| `topic_created_score_value` | 1 |
| `post_created_score_value` | 2 |
| `first_reply_of_day_score_value` | 1 |
| `flag_created_score_value` | 10 |
| `day_visited_score_value` | 1 |
| `day_visited_weekend_score_value` | 20 |
| `reaction_received_score_value` | 1 |
| `reaction_given_score_value` | 1 |
| `chat_reaction_received_score_value` | 1 |
| `chat_reaction_given_score_value` | 1 |
| `chat_message_created_score_value` | 1 |
| `post_created_event_score_value` | 2 |
| `accepted_solution_event_score_value` | 5 |
| `accepted_solution_topic_event_score_value` | 2 |

`post_created_event_score_value` awards points only for creating new topics, not for replies.

Set any of these values to `0` to disable scoring for that action. Changes take
effect immediately for new events.

### Gamification Score Events

The `gamification_score_events` table stores the history of points awarded. Important columns include:
- `user_id` and `date` of the event
- `points` amount and `reason`
- optional `description`
- `related_id` identifies the topic, reply or other entity linked to the event
- `related_type` describes the entity type such as `topic`, `reply` or `user`

