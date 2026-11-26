# Lab 1A Boilerplate: File Structuring | Design Pattern

Starter code for Laboratory Activity 1A. Copy these files into your
Flutter project (folder `surname_mobprog`), replacing `surname` with
your own surname.

## Lab Discussion

**How do you integrate the Image widget into `newsfeed_card.dart` so it
shows only when a post has an image?**

Each post has an optional image path. In the `Post` model
(`newsfeed_screen.dart`) and in `NewsFeedCard`, the field is nullable:

```dart
final String? imageAsset;
```

A post with no image passes `imageAsset: null` (Post 1). A post with an
image passes the asset path, for example
`'assets/images/post_image.png'` (Post 2).

Inside the card's `Column`, the image is added with a collection `if`.
This is Dart syntax that adds a widget to a list only when a condition
is true:

```dart
if (imageAsset != null)
  ClipRRect(
    borderRadius: BorderRadius.circular(8.r),
    child: Image.asset(
      imageAsset!,
      width: double.infinity,
      height: 200.h,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          height: 200.h,
          color: AppColors.lightGrey,
          alignment: Alignment.center,
          child: const CustomText(text: 'Post image', color: AppColors.grey),
        );
      },
    ),
  ),
```

- When `imageAsset` is `null`, the `if` is false. The widget is never
  built and takes no space, so Post 1 goes straight from its text to
  the likes row.
- When `imageAsset` has a value, `Image.asset` loads the file from
  `assets/images/`. The `!` tells Dart the value is not null, which is
  already checked. `width: double.infinity` and `BoxFit.cover` make the
  image fill the card's width, and `ClipRRect` rounds its corners.
- `errorBuilder` is the placeholder. If the file is missing or cannot
  load, a grey box with the text "Post image" is shown instead of the
  app crashing.
- The image folder must be listed in `pubspec.yaml` under
  `flutter: assets:` (`- assets/images/`), or Flutter cannot find it.

The same nullable field pattern works for other optional content. Only
the data decides what the card shows, and the card widget stays
reusable for every post.

### Enhancements done

1. **Image widget**: the post image uses `Image.asset`, shown only when
   the post has an image, with a grey placeholder if loading fails.
2. **Profile avatar**: `CircleAvatar` uses
   `AssetImage('assets/images/avatar.jpg')` instead of the person icon.
3. **Widget-based buttons**: Like, Comment, and Share are
   `TextButton.icon` widgets (in `_ActionButton`) with padding, rounded
   corners, and a tap effect. Like is Facebook blue.

Fonts: Frutiger is the app's default font, and Klavika Bold is used
for the "facebook" title.

## Files

- `pubspec.yaml` - project name, flutter_screenutil 5.9.3, provider 6.1.5.
- `lib/main.dart` - app entry: ScreenUtilInit (360x690), MaterialApp,
  routes `/home` and `/newsfeed`.
- `lib/constants.dart` - colors used in many places (Facebook blue).
- `lib/screens/home_screen.dart` - "facebook" app bar, bottom navigation
  (Home, Notifications).
- `lib/screens/newsfeed_screen.dart` - the list of two posts, and the
  `Post` model.
- `lib/widgets/custom_text.dart` - reusable text widget (DRY).
- `lib/widgets/newsfeed_card.dart` - one post card: avatar, name, date,
  post text, optional image, like/comment/share, "Write a comment...".

## Your TODOs

1. In `pubspec.yaml`, replace `surname` with your own surname.
2. In `newsfeed_screen.dart`, Post 1 is YOUR post: replace 'Your Name'
   with your own name and write your own post text. Post 2 is by a
   CLASSMATE you pick: replace "Classmate's Name" with their name.
3. An image file named `post_image.png` is already in `assets/images/`
   (a placeholder). Replace it with your own image, or change the
   `imageAsset` path to your own image. If the file is missing, the card
   shows a grey placeholder instead of crashing.
   Fonts are optional: the font lines in `pubspec.yaml` are commented out.
   Add your font files to `assets/fonts/` and uncomment them to use them.
4. Do the three enhancements (image widget, avatar, widget-based
   like/comment buttons). Each one is marked with a TODO in the code.

## Run it

```
flutter pub get
flutter run
```

## Submit

Follow the Requirements for Submission in the activity file: the
discussion answer in README.md, screenshots before and after the
enhancement, and the link to your GitHub project repository.
