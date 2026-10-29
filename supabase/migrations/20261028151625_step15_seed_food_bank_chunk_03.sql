DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  
  -- Base food: خورشت فسنجان با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خورشت فسنجان با برنج', 'compound', 'lunch', NULL, 'lunch:19:خورشت-فسنجان-با-برنج', 'فسنجان با مرغ، بدون شکر و روغن اضافه. بخش خورشتی شامل گردو، رب انار و پیاز، بدون مرغ است؛ هر ۱۰۰ گرم حدود ۲۰۰ کالری / ۴ گرم پروتئین. نکته: میزان گردو و غلظت فسنجان تأثیر زیادی بر کالری دارد؛ این برآورد برای فسنجان خیلی غلیظ، پرگردو یا شیرین معتبر نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت فسنجان با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 35,
    'lunch:19:خورشت-فسنجان-با-برنج:450', '[{"name":"بخش خورشتی بدون مرغ","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۸۰ گرم","household":"حدود ¾ کف دست"},{"name":"برنج","amount":"۶۰ گرم","household":"۶ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 36g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت فسنجان با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 36,
    'lunch:19:خورشت-فسنجان-با-برنج:500', '[{"name":"بخش خورشتی بدون مرغ","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۸۰ گرم","household":null},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 37g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت فسنجان با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 37,
    'lunch:19:خورشت-فسنجان-با-برنج:550', '[{"name":"بخش خورشتی بدون مرغ","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۸۰ گرم","household":null},{"name":"برنج","amount":"۱۴۰ گرم","household":"۱۴ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خورشت بادمجان با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خورشت بادمجان با برنج', 'compound', 'lunch', NULL, 'lunch:20:خورشت-بادمجان-با-برنج', 'بادمجان تنوری یا پخته با روغن کم، گوجه، رب و پیاز؛ هر ۱۵۰ گرم بخش خورشتی بدون گوشت حدود ۱۰۰ کالری / ۲ گرم پروتئین. بادمجان داخل همین ۱۵۰ گرم است، نه علاوه بر آن. برای بادمجان کامل، وزن‌کردن از معادل قاشقی دقیق‌تر است. بادمجان پرروغن کالری بیشتری دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت بادمجان با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 26,
    'lunch:20:خورشت-بادمجان-با-برنج:450', '[{"name":"بخش خورشتی شامل بادمجان، بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت کم‌چرب پخته","amount":"۶۰ گرم","household":"کمی بیشتر از ½ کف دست"},{"name":"برنج","amount":"۱۰۵ گرم","household":"۱۰½ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت بادمجان با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 27,
    'lunch:20:خورشت-بادمجان-با-برنج:500', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۴۵ گرم","household":"۱۴½ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت بادمجان با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 28,
    'lunch:20:خورشت-بادمجان-با-برنج:550', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۸۰ گرم","household":"۱۸ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماکارونی با گوشت چرخ‌کرده (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماکارونی با گوشت چرخ‌کرده', 'compound', 'lunch', NULL, 'lunch:21:ماکارونی-با-گوشت-چرخکرده', 'گوشت و روغن داخل وزن غذا هستند. معادل پیمانه به شکل ماکارونی وابسته است؛ برای ماکارونی رشته‌ای، قاشق سرصاف معیار مناسبی نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 165 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 165 کالری', 'compound', 'lunch', NULL,
    v_base_id, '165 کالری', 165, 10,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:165', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 27,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:450', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۲۵ گرم","household":"حدود ۱½ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 30,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:500', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۵۵ گرم","household":"حدود ۱⅔ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 33,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:550', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۸۵ گرم","household":"حدود ۱¾ تا ۲ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماکارونی با مرغ (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماکارونی با مرغ', 'compound', 'lunch', NULL, 'lunch:22:ماکارونی-با-مرغ', 'ماکارونی، مرغ ریش‌ریش، رب، پیاز و روغن کم؛ بدون خامه و پنیر. هر ۱۰۰ گرم آماده حدود ۱۵۵ کالری / ۱۰ گرم پروتئین. مرغ داخل وزن ماکارونی حساب شده است؛ نان و ته‌دیگ اضافه در این سهم نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با مرغ — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 29,
    'lunch:22:ماکارونی-با-مرغ:450', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۴۰ گرم","household":"حدود ۱½ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 32g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با مرغ — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 32,
    'lunch:22:ماکارونی-با-مرغ:500', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۷۰ گرم","household":"حدود ۱¾ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با مرغ — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 35,
    'lunch:22:ماکارونی-با-مرغ:550', '[{"name":"ماکارونی مخلوط آماده","amount":"۳۰۵ گرم","household":"حدود ۲ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: آبگوشت با نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('آبگوشت با نان', 'compound', 'lunch', NULL, 'lunch:24:آبگوشت-با-نان', 'بدون دنبه و با جداکردن چربی قابل‌مشاهده. مواد جدا ثبت شده‌اند؛ اگر آن‌ها را بکوبی، مجموع همین سهم‌ها مقدار گوشت‌کوبیدهٔ وعده است. نان تلیت‌شده، بخشی از همین سهم نان است؛ نانِ همراه گوشت‌کوبیده هم باید از همین مقدار برداشته شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 31g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آبگوشت با نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 31,
    'lunch:24:آبگوشت-با-نان:450', '[{"name":"گوشت کم‌چرب پخته","amount":"۶۰ گرم","household":"کمی بیشتر از ½ کف دست"},{"name":"نخود و لوبیای پخته","amount":"۸۰ گرم","household":"حدود ۵–۶ قاشق سرصاف"},{"name":"سیب‌زمینی پخته","amount":"۵۰ گرم","household":"نصف سیب‌زمینی کوچک"},{"name":"آبِ آبگوشت کم‌چرب","amount":"۱۵۰ گرم","household":"۱ کاسهٔ کوچک کم‌پُر"},{"name":"نان","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آبگوشت با نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 33,
    'lunch:24:آبگوشت-با-نان:500', '[{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"نخود و لوبیای پخته","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"سیب‌زمینی پخته","amount":"۵۰ گرم","household":"نصف سیب‌زمینی کوچک"},{"name":"آبِ آبگوشت کم‌چرب","amount":"۱۵۰ گرم","household":"۱ کاسهٔ کوچک کم‌پُر"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 34g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آبگوشت با نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 34,
    'lunch:24:آبگوشت-با-نان:550', '[{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"نخود و لوبیای پخته","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"سیب‌زمینی پخته","amount":"۵۰ گرم","household":"نصف سیب‌زمینی کوچک"},{"name":"آبِ آبگوشت کم‌چرب","amount":"۱۵۰ گرم","household":"۱ کاسهٔ کوچک کم‌پُر"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کباب کوبیده با برنج یا نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کباب کوبیده با برنج یا نان', 'compound', 'lunch', NULL, 'lunch:25:کباب-کوبیده-با-برنج-یا-نان', 'کوبیده با چربی متوسط؛ هر ۱۰۰ گرم پخته حدود ۲۷۰ کالری / ۲۳ گرم پروتئین. بدون کرهٔ اضافه. با نان، پروتئین نسخه‌ها حدود ۳۰، ۳۲ و ۳۳ گرم است. هر سیخ رستورانی الزاماً ۹۰ گرم نیست؛ وزن و میزان چربی باید در نظر گرفته شوند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب کوبیده با برنج یا نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 28,
    'lunch:25:کباب-کوبیده-با-برنج-یا-نان:450', '[{"name":"کوبیده پخته","amount":"۹۰ گرم","household":"۱ سیخ کوچک با همین وزن پخته"},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان ۵۰ گرم","household":"۱⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب کوبیده با برنج یا نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 29,
    'lunch:25:کباب-کوبیده-با-برنج-یا-نان:500', '[{"name":"کوبیده پخته","amount":"۹۰ گرم","household":"۱ سیخ کوچک"},{"name":"برنج","amount":"۱۳۵ گرم","household":"۱۳½ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان حدود ۷۰ گرم","household":"۲⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب کوبیده با برنج یا نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 30,
    'lunch:25:کباب-کوبیده-با-برنج-یا-نان:550', '[{"name":"کوبیده پخته","amount":"۹۰ گرم","household":"۱ سیخ کوچک"},{"name":"برنج","amount":"۱۷۵ گرم","household":"۱۷½ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان حدود ۹۰ گرم","household":"۳ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ مرغ (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ مرغ', 'compound', 'dinner', NULL, 'dinner:1:ساندویچ-مرغ', 'مرغ بدون پوست، بدون مایونز، پنیر و سیب‌زمینی سرخ‌شده. روغن نوشته‌شده، سهم پخت مرغ همان وعده است. سبزیجات همراه می‌توانند داخل ساندویچ قرار بگیرند. برای جایگزینی نان سنگک با نان ساندویچی، وزن و کالری روی بسته ملاک است؛ یک عدد نان ساندویچی اندازهٔ ثابتی ندارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 38g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ مرغ — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 38,
    'dinner:1:ساندویچ-مرغ:400', '[{"name":"مرغ پخته و ریش‌ریش","amount":"۹۰ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"نان سنگک","amount":"۵۵ گرم","household":"کمی کمتر از ۲ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 39g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ مرغ — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 39,
    'dinner:1:ساندویچ-مرغ:450', '[{"name":"مرغ پخته و ریش‌ریش","amount":"۹۰ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"نان سنگک","amount":"۷۵ گرم","household":"۲٫۵ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 41g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ مرغ — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 41,
    'dinner:1:ساندویچ-مرغ:500', '[{"name":"مرغ پخته و ریش‌ریش","amount":"۹۰ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"نان سنگک","amount":"۹۵ گرم","household":"کمی بیشتر از ۳ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ تخم‌مرغ (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ تخم‌مرغ', 'compound', 'dinner', NULL, 'dinner:2:ساندویچ-تخممرغ', 'تخم‌مرغ آب‌پز یا پخته در تابهٔ نچسب؛ بدون مایونز و پنیر.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 23,
    'dinner:2:ساندویچ-تخممرغ:400', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"روغن","amount":"۲ گرم","household":"کمی کمتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 24,
    'dinner:2:ساندویچ-تخممرغ:450', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۸۰ گرم","household":"۲⅔ کف دست"},{"name":"روغن","amount":"۲ گرم","household":"کمی کمتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 26,
    'dinner:2:ساندویچ-تخممرغ:500', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۱۰۰ گرم","household":"۳⅓ کف دست"},{"name":"روغن","amount":"۲ گرم","household":"کمی کمتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 20 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 20 کالری', 'compound', 'dinner', NULL,
    v_base_id, '20 کالری', 20, NULL,
    'dinner:2:ساندویچ-تخممرغ:20', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ تن ماهی (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ تن ماهی', 'compound', 'dinner', NULL, 'dinner:3:ساندویچ-تن-ماهی', 'تن ماهی روغنی پس از تخلیهٔ روغن قابل‌جداشدن؛ هر ۱۰۰ گرم آبکش‌شده حدود ۱۹۰ کالری / ۲۶ گرم پروتئین. بدون مایونز و روغن اضافه. وزن خالص قوطی با وزن تنِ آبکش‌شده یکی نیست. برچسب محصول مبنای دقیق‌تر کالری است؛ آماده‌سازی کنسرو را مطابق دستور روی بسته انجام بده.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تن ماهی — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 35,
    'dinner:3:ساندویچ-تن-ماهی:400', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۰۰ گرم","household":"حدود ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 37g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تن ماهی — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 37,
    'dinner:3:ساندویچ-تن-ماهی:450', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۰۰ گرم","household":"حدود ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 39g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تن ماهی — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 39,
    'dinner:3:ساندویچ-تن-ماهی:500', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۰۰ گرم","household":"حدود ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"نان","amount":"۹۰ گرم","household":"۳ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ کتلت (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ کتلت', 'compound', 'dinner', NULL, 'dinner:4:ساندویچ-کتلت', 'کتلت فرپز یا تابه‌ای با گوشت نسبتاً کم‌چرب، سیب‌زمینی، تخم‌مرغ و روغن محدود؛ هر ۱۰۰ گرم آماده حدود ۱۸۰ کالری / ۱۰ گرم پروتئین. روغن پخت داخل وزن و کالری کتلت حساب شده است. مایونز، سیب‌زمینی سرخ‌شده و روغن اضافه در این سهم نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ کتلت — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 20,
    'dinner:4:ساندویچ-کتلت:400', '[{"name":"کتلت آماده","amount":"۱۲۰ گرم","household":"۲ عدد متوسطِ ۶۰ گرمی"},{"name":"نان","amount":"۴۰ گرم","household":"۱⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ کتلت — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 22,
    'dinner:4:ساندویچ-کتلت:450', '[{"name":"کتلت آماده","amount":"۱۲۰ گرم","household":"۲ عدد متوسطِ ۶۰ گرمی"},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ کتلت — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 24,
    'dinner:4:ساندویچ-کتلت:500', '[{"name":"کتلت آماده","amount":"۱۲۰ گرم","household":"۲ عدد متوسطِ ۶۰ گرمی"},{"name":"نان","amount":"۸۰ گرم","household":"۲⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;