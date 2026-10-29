DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: سالاد تن ماهی (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سالاد تن ماهی', 'compound', 'dinner', NULL, 'dinner:23:سالاد-تن-ماهی', 'تن ماهی روغنی پس از تخلیهٔ روغن، سبزیجات و سس ماستی؛ بدون روغن و مایونز اضافه. سبزیجات و ماست زیر جایگزین همراه ثابت هستند. همراه ثابت دوباره اضافه نمی‌شود. سس از ماست نوشته‌شده با آب‌لیمو و ادویه تهیه می‌شود؛ ذرت، لوبیا، سیب‌زمینی و روغن داخل قوطی در این سهم نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 38g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد تن ماهی — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 38,
    'dinner:23:سالاد-تن-ماهی:400', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۱۵ گرم","household":"کمی بیشتر از ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"کاهو، خیار و گوجه خردشده","amount":"۲۰۰ گرم","household":"۲ لیوان یا ۱ کاسهٔ متوسط"},{"name":"ماست کم‌چرب برای سس","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"نان","amount":"۳۰ گرم","household":"۱ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 40g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد تن ماهی — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 40,
    'dinner:23:سالاد-تن-ماهی:450', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۱۵ گرم","household":"کمی بیشتر از ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"کاهو، خیار و گوجه خردشده","amount":"۲۰۰ گرم","household":"۲ لیوان یا ۱ کاسهٔ متوسط"},{"name":"ماست کم‌چرب برای سس","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 42g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد تن ماهی — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 42,
    'dinner:23:سالاد-تن-ماهی:500', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۱۵ گرم","household":"کمی بیشتر از ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"کاهو، خیار و گوجه خردشده","amount":"۲۰۰ گرم","household":"۲ لیوان یا ۱ کاسهٔ متوسط"},{"name":"ماست کم‌چرب برای سس","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: سالاد الویه با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سالاد الویه با نان', 'compound', 'dinner', NULL, 'dinner:24:سالاد-الویه-با-نان', 'مرغ، سیب‌زمینی، تخم‌مرغ و سس داخل وزن الویه حساب شده‌اند. ماست همراه ثابت جدا از ماست داخل سس است. الویهٔ پرمایونز یا تهیه‌شده با کالباس، جایگزین مستقیم این نسخه نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد الویه با نان — 150 کالری', 'compound', 'dinner', NULL,
    v_base_id, '150 کالری', 150, 8,
    'dinner:24:سالاد-الویه-با-نان:150', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد الویه با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 21,
    'dinner:24:سالاد-الویه-با-نان:400', '[{"name":"الویهٔ سبک آماده","amount":"۱۸۵ گرم","household":"حدود ۱۲ قاشق غذاخوری سرصاف یا ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۱۵ گرم","household":"½ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد الویه با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 23,
    'dinner:24:سالاد-الویه-با-نان:450', '[{"name":"الویهٔ سبک آماده","amount":"۱۸۵ گرم","household":"حدود ۱۲ قاشق غذاخوری سرصاف یا ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد الویه با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 24,
    'dinner:24:سالاد-الویه-با-نان:500', '[{"name":"الویهٔ سبک آماده","amount":"۱۸۵ گرم","household":"حدود ۱۲ قاشق غذاخوری سرصاف یا ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۵۵ گرم","household":"کمی کمتر از ۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: نان، پنیر، گردو و شیر (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('نان، پنیر، گردو و شیر', 'compound', 'dinner', NULL, 'dinner:25:نان،-پنیر،-گردو-و-شیر', 'پنیر سفید معمولی و شیر کم‌چرب. در این گزینه همراه ثابت و ماست اضافه نمی‌شود؛ شیر و سبزیجات زیر جزء خود وعده هستند. نوع پنیر، درصد چربی شیر و اندازهٔ مغز گردو بر کالری اثر دارند. پنیر خامه‌ای و شیر پرچرب، جایگزین مستقیم مواد این محاسبه نیستند. میان وعده ها: مقدارها، کالری و پروتئین تقریبی‌اند. هر لیوان استاندارد شیر ۲۳۰ میلی‌لیتر و هر کف دست نان سنگک بدون انگشتان حدود ۳۰ گرم در نظر گرفته شده است. برای محصولات بسته‌بندی‌شده، برچسب همان محصول بر این برآوردها اولویت دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 19,
    'dinner:25:نان،-پنیر،-گردو-و-شیر:400', '[{"name":"نان","amount":"۵۵ گرم","household":"کمی کمتر از ۲ کف دست"},{"name":"پنیر سفید","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"مغز گردو","amount":"۱۰ گرم","household":"۲ مغز کامل متوسط یا ۴ نیمه"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"کمی کمتر از ۱ لیوان"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 21,
    'dinner:25:نان،-پنیر،-گردو-و-شیر:450', '[{"name":"نان","amount":"۷۵ گرم","household":"۲٫۵ کف دست"},{"name":"پنیر سفید","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"مغز گردو","amount":"۱۰ گرم","household":"۲ مغز کامل متوسط یا ۴ نیمه"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"کمی کمتر از ۱ لیوان"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 23,
    'dinner:25:نان،-پنیر،-گردو-و-شیر:500', '[{"name":"نان","amount":"۹۵ گرم","household":"کمی بیشتر از ۳ کف دست"},{"name":"پنیر سفید","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"مغز گردو","amount":"۱۰ گرم","household":"۲ مغز کامل متوسط یا ۴ نیمه"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"کمی کمتر از ۱ لیوان"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 200 کالری', 'compound', 'dinner', NULL,
    v_base_id, '200 کالری', 200, NULL,
    'dinner:25:نان،-پنیر،-گردو-و-شیر:200', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
