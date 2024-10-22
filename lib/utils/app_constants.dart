import 'package:mood_track/model/mood_emoji.dart';

class AppConstants {
  static const String appName = 'Mood Tracking App';

  static List<MoodEmoji> listEmoji = [
    MoodEmoji(moodEmoji: '😊', moodTitle: 'Happy'),
    MoodEmoji(moodEmoji: '☹️', moodTitle: 'Sad'),
    MoodEmoji(moodEmoji: '😂', moodTitle: 'Funny'),
    MoodEmoji(moodEmoji: '😔', moodTitle: 'Shameful'),
    MoodEmoji(moodEmoji: '🤦', moodTitle: 'Tired'),
    MoodEmoji(moodEmoji: '😩', moodTitle: 'Panicked'),
  ];

  // static List<List<Activity>> moodActivities = [
  //   // Activities for Happiness/Joy
  //   [
  //     Activity(
  //       name: "Go for a walk in the park",
  //       description: "Enjoy the fresh air and beautiful scenery.",
  //     ),
  //     Activity(
  //       name: "Call a friend",
  //       description: "Connect with a loved one and share your happiness.",
  //     ),
  //     Activity(
  //       name: "Watch a funny movie",
  //       description: "Laugh and relax with an entertaining film.",
  //     ),
  //     Activity(
  //       name: "Dance to your favorite music",
  //       description: "Let loose and move your body to uplifting tunes.",
  //     ),
  //     Activity(
  //       name: "Cook a delicious meal",
  //       description: "Channel your creativity and make something tasty.",
  //     ),
  //   ],
  //   // Activities for Sadness
  //   [
  //     Activity(
  //       name: "Listen to calming music",
  //       description: "Let soothing melodies comfort your soul.",
  //     ),
  //     Activity(
  //       name: "Write in a journal",
  //       description: "Express your thoughts and emotions on paper.",
  //     ),
  //     Activity(
  //       name: "Take a warm bath",
  //       description: "Relax and unwind in a soothing bath.",
  //     ),
  //     Activity(
  //       name: "Cuddle with a pet",
  //       description: "Seek comfort and companionship from a furry friend.",
  //     ),
  //     Activity(
  //       name: "Watch a heartfelt movie",
  //       description: "Feel a connection and empathy through a touching film.",
  //     ),
  //   ],
  //   // Activities for Funny
  //   [
  //     Activity(
  //       name: "Attend a comedy show",
  //       description: "Laugh out loud at live stand-up comedy performances.",
  //     ),
  //     Activity(
  //       name: "Play a board game with friends",
  //       description: "Enjoy some friendly competition and laughter.",
  //     ),
  //     Activity(
  //       name: "Watch funny videos online",
  //       description: "Find hilarious videos to brighten your mood.",
  //     ),
  //     Activity(
  //       name: "Tell jokes with family",
  //       description: "Share funny stories and jokes with your loved ones.",
  //     ),
  //     Activity(
  //       name: "Create a meme",
  //       description: "Express humor and creativity by making your own memes.",
  //     ),
  //   ],
  //   // Activities for Shameful
  //   [
  //     Activity(
  //       name: "Reflect on your actions",
  //       description:
  //           "Take time to think about what led to your feelings of shame.",
  //     ),
  //     Activity(
  //       name: "Apologize to those you've wronged",
  //       description: "Acknowledge your mistakes and seek forgiveness.",
  //     ),
  //     Activity(
  //       name: "Seek guidance from a trusted friend or mentor",
  //       description:
  //           "Talk to someone you trust about your feelings and seek advice.",
  //     ),
  //     Activity(
  //       name: "Practice self-compassion",
  //       description:
  //           "Be kind to yourself and recognize that everyone makes mistakes.",
  //     ),
  //     Activity(
  //       name: "Learn from your experiences",
  //       description:
  //           "Use your feelings of shame as an opportunity for personal growth.",
  //     ),
  //   ],
  //   // Activities for Tired
  //   [
  //     Activity(
  //       name: "Take a power nap",
  //       description: "Rest and recharge with a short nap.",
  //     ),
  //     Activity(
  //       name: "Drink a cup of coffee or tea",
  //       description: "Boost your energy levels with a caffeine pick-me-up.",
  //     ),
  //     Activity(
  //       name: "Stretch or do yoga",
  //       description:
  //           "Relieve tension and increase circulation with gentle stretches.",
  //     ),
  //     Activity(
  //       name: "Listen to upbeat music",
  //       description: "Find motivation and energy in lively tunes.",
  //     ),
  //     Activity(
  //       name: "Go for a brisk walk",
  //       description:
  //           "Get your blood pumping and increase alertness with physical activity.",
  //     ),
  //   ],
  //   // Activities for Angry
  //   [
  //     Activity(
  //       name: "Practice deep breathing",
  //       description: "Calm your mind and body with slow, deep breaths.",
  //     ),
  //     Activity(
  //       name: "Take a time-out",
  //       description:
  //           "Step away from the situation to cool off and gain perspective.",
  //     ),
  //     Activity(
  //       name: "Write down your feelings",
  //       description: "Release pent-up emotions by journaling or venting.",
  //     ),
  //     Activity(
  //       name: "Engage in physical activity",
  //       description:
  //           "Channel anger into a productive outlet like exercise or sports.",
  //     ),
  //     Activity(
  //       name: "Talk to a trusted friend or therapist",
  //       description:
  //           "Share your feelings and seek support from someone you trust.",
  //     ),
  //   ],
  //   // Activities for Proud
  //   [
  //     Activity(
  //       name: "Celebrate your achievements",
  //       description:
  //           "Acknowledge and appreciate your accomplishments, big and small.",
  //     ),
  //     Activity(
  //       name: "Share your success with loved ones",
  //       description: "Express gratitude and pride with friends and family.",
  //     ),
  //     Activity(
  //       name: "Set new goals",
  //       description:
  //           "Channel your confidence and motivation into setting ambitious new goals.",
  //     ),
  //     Activity(
  //       name: "Help others achieve their goals",
  //       description:
  //           "Use your success to inspire and support others in their endeavors.",
  //     ),
  //     Activity(
  //       name: "Reflect on your journey",
  //       description:
  //           "Take pride in how far you've come and the obstacles you've overcome.",
  //     ),
  //   ],
  // ];
}
