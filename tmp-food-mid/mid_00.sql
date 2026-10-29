DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: نان، تخم‌مرغ و پنیر (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('نان، تخم‌مرغ و پنیر', 'compound', 'breakfast', NULL, 'breakfast:1:نان،-تخممرغ-و-پنیر', NULL)
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، تخم‌مرغ و پنیر — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 18,
    'breakfast:1:نان،-تخممرغ-و-پنیر:350', '[{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"تخم‌مرغ آب‌پز","amount":"۱ عدد متوسط","household":null},{"name":"پنیر","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ قوطی کبریت"},{"name":"خیار و گوجه","amount":"۷۰ گرم","household":"نصف پیمانه خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، تخم‌مرغ و پنیر — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 20,
    'breakfast:1:نان،-تخممرغ-و-پنیر:400', '[{"name":"نان","amount":"۸۵ گرم","household":"حدود ۳ کف دست"},{"name":"تخم‌مرغ آب‌پز","amount":"۱ عدد متوسط","household":null},{"name":"پنیر","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ قوطی کبریت"},{"name":"خیار و گوجه","amount":"۷۰ گرم","household":"نصف پیمانه خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، تخم‌مرغ و پنیر — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 21,
    'breakfast:1:نان،-تخممرغ-و-پنیر:450', '[{"name":"نان","amount":"۱۰۵ گرم","household":"۳٫۵ کف دست"},{"name":"تخم‌مرغ آب‌پز","amount":"۱ عدد متوسط","household":null},{"name":"پنیر","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ قوطی کبریت"},{"name":"خیار و گوجه","amount":"۷۰ گرم","household":"نصف پیمانه خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: تخم‌مرغ آب‌پز و نان (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('تخم‌مرغ آب‌پز و نان', 'compound', 'breakfast', NULL, 'breakfast:2:تخممرغ-آبپز-و-نان', NULL)
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز و نان — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 20,
    'breakfast:2:تخممرغ-آبپز-و-نان:350', '[{"name":"تخم‌مرغ آب‌پز","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز و نان — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 22,
    'breakfast:2:تخممرغ-آبپز-و-نان:400', '[{"name":"تخم‌مرغ آب‌پز","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۹۰ گرم","household":"۳ کف دست"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'تخم‌مرغ آب‌پز و نان — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 24,
    'breakfast:2:تخممرغ-آبپز-و-نان:450', '[{"name":"تخم‌مرغ آب‌پز","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۱۱۰ گرم","household":"۳⅔ کف دست"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: نیمرو و نان (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('نیمرو و نان', 'compound', 'breakfast', NULL, 'breakfast:3:نیمرو-و-نان', 'روش پخت: تابهٔ نچسب؛ بدون کره یا روغن اضافه.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نیمرو و نان — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 18,
    'breakfast:3:نیمرو-و-نان:350', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۵۵ گرم","household":"کمی کمتر از ۲ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نیمرو و نان — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 20,
    'breakfast:3:نیمرو-و-نان:400', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۷۵ گرم","household":"۲٫۵ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نیمرو و نان — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 22,
    'breakfast:3:نیمرو-و-نان:450', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۹۵ گرم","household":"کمی بیشتر از ۳ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ پیمانه کم‌پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: املت گوجه‌فرنگی و نان (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('املت گوجه‌فرنگی و نان', 'compound', 'breakfast', NULL, 'breakfast:4:املت-گوجهفرنگی-و-نان', 'روش پخت: ابتدا گوجه با روغن مشخص‌شده و کمی آب نرم شود؛ سپس تخم‌مرغ اضافه شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت گوجه‌فرنگی و نان — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 18,
    'breakfast:4:املت-گوجهفرنگی-و-نان:350', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"گوجه","amount":"۱۵۰ گرم","household":"۱ عدد بزرگ یا ۲ عدد کوچک"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت گوجه‌فرنگی و نان — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 20,
    'breakfast:4:املت-گوجهفرنگی-و-نان:400', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"گوجه","amount":"۱۵۰ گرم","household":"۱ عدد بزرگ یا ۲ عدد کوچک"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت گوجه‌فرنگی و نان — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 22,
    'breakfast:4:املت-گوجهفرنگی-و-نان:450', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"گوجه","amount":"۱۵۰ گرم","household":"۱ عدد بزرگ یا ۲ عدد کوچک"},{"name":"نان","amount":"۹۰ گرم","household":"۳ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: املت قارچ و نان (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('املت قارچ و نان', 'compound', 'breakfast', NULL, 'breakfast:5:املت-قارچ-و-نان', 'روش پخت: بدون خامه، پنیر یا کرهٔ اضافه.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت قارچ و نان — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 21,
    'breakfast:5:املت-قارچ-و-نان:350', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"قارچ خام","amount":"۱۰۰ گرم","household":"۵–۶ عدد متوسط"},{"name":"گوجه","amount":"۵۰ گرم","household":"نصف گوجهٔ متوسط"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت قارچ و نان — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 22,
    'breakfast:5:املت-قارچ-و-نان:400', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"قارچ خام","amount":"۱۰۰ گرم","household":"۵–۶ عدد متوسط"},{"name":"گوجه","amount":"۵۰ گرم","household":"نصف گوجهٔ متوسط"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت قارچ و نان — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 24,
    'breakfast:5:املت-قارچ-و-نان:450', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"قارچ خام","amount":"۱۰۰ گرم","household":"۵–۶ عدد متوسط"},{"name":"گوجه","amount":"۵۰ گرم","household":"نصف گوجهٔ متوسط"},{"name":"نان","amount":"۹۰ گرم","household":"۳ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: عدسی و نان (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('عدسی و نان', 'compound', 'breakfast', NULL, 'breakfast:6:عدسی-و-نان', NULL)
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدسی و نان — 110 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '110 کالری', 110, 7,
    'breakfast:6:عدسی-و-نان:110', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 350 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدسی و نان — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 19,
    'breakfast:6:عدسی-و-نان:350', '[{"name":"عدسی آماده","amount":"۲۰۰ گرم","household":"۱ پیمانه یا ۱ کاسهٔ متوسط کم‌پُر"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"آب‌لیمو، دارچین یا گلپر","amount":"به مقدار دلخواه، بدون شکر","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدسی و نان — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 20,
    'breakfast:6:عدسی-و-نان:400', '[{"name":"عدسی آماده","amount":"۲۰۰ گرم","household":"۱ پیمانه یا ۱ کاسهٔ متوسط کم‌پُر"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"آب‌لیمو، دارچین یا گلپر","amount":"به مقدار دلخواه، بدون شکر","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدسی و نان — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 22,
    'breakfast:6:عدسی-و-نان:450', '[{"name":"عدسی آماده","amount":"۲۰۰ گرم","household":"۱ پیمانه یا ۱ کاسهٔ متوسط کم‌پُر"},{"name":"نان","amount":"۹۰ گرم","household":"۳ کف دست"},{"name":"آب‌لیمو، دارچین یا گلپر","amount":"به مقدار دلخواه، بدون شکر","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: نان، پنیر، گردو و شیر (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('نان، پنیر، گردو و شیر', 'compound', 'breakfast', NULL, 'breakfast:7:نان،-پنیر،-گردو-و-شیر', NULL)
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 16,
    'breakfast:7:نان،-پنیر،-گردو-و-شیر:350', '[{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"پنیر","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"گردو","amount":"۱۰ گرم","household":"۲ مغز کامل متوسط"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"چهارپنجم لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 18,
    'breakfast:7:نان،-پنیر،-گردو-و-شیر:400', '[{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"پنیر","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"گردو","amount":"۱۰ گرم","household":"۲ مغز کامل متوسط"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"چهارپنجم لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 20,
    'breakfast:7:نان،-پنیر،-گردو-و-شیر:450', '[{"name":"نان","amount":"۸۵ گرم","household":"حدود ۳ کف دست"},{"name":"پنیر","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"گردو","amount":"۱۰ گرم","household":"۲ مغز کامل متوسط"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"چهارپنجم لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: نان، پنیر، خیار و گوجه (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('نان، پنیر، خیار و گوجه', 'compound', 'breakfast', NULL, 'breakfast:8:نان،-پنیر،-خیار-و-گوجه', 'نکته: این مقادیر برای پنیر سفید معمولی محاسبه شده‌اند؛ پنیر خامه‌ای جایگزین مستقیم آن نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، خیار و گوجه — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 16,
    'breakfast:8:نان،-پنیر،-خیار-و-گوجه:350', '[{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"پنیر","amount":"۶۰ گرم","household":"۲ قوطی کبریت"},{"name":"خیار و گوجه","amount":"۱۵۰ گرم","household":"۱ پیمانهٔ پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، خیار و گوجه — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 18,
    'breakfast:8:نان،-پنیر،-خیار-و-گوجه:400', '[{"name":"نان","amount":"۸۵ گرم","household":"حدود ۳ کف دست"},{"name":"پنیر","amount":"۶۰ گرم","household":"۲ قوطی کبریت"},{"name":"خیار و گوجه","amount":"۱۵۰ گرم","household":"۱ پیمانهٔ پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، خیار و گوجه — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 19,
    'breakfast:8:نان،-پنیر،-خیار-و-گوجه:450', '[{"name":"نان","amount":"۱۰۵ گرم","household":"۳٫۵ کف دست"},{"name":"پنیر","amount":"۶۰ گرم","household":"۲ قوطی کبریت"},{"name":"خیار و گوجه","amount":"۱۵۰ گرم","household":"۱ پیمانهٔ پُر خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: نان، کره بادام‌زمینی، موز و شیر (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('نان، کره بادام‌زمینی، موز و شیر', 'compound', 'breakfast', NULL, 'breakfast:9:نان،-کره-بادامزمینی،-موز-و-شیر', NULL)
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 14g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره بادام‌زمینی، موز و شیر — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 14,
    'breakfast:9:نان،-کره-بادامزمینی،-موز-و-شیر:350', '[{"name":"نان","amount":"۳۰ گرم","household":"۱ کف دست"},{"name":"کره بادام‌زمینی","amount":"۱۵ گرم","household":"۱ قاشق غذاخوری سرصاف"},{"name":"موز بدون پوست","amount":"۱۰۰ گرم","household":"۱ عدد کوچک"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"چهارپنجم لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره بادام‌زمینی، موز و شیر — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 16,
    'breakfast:9:نان،-کره-بادامزمینی،-موز-و-شیر:400', '[{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"کره بادام‌زمینی","amount":"۱۵ گرم","household":"۱ قاشق غذاخوری سرصاف"},{"name":"موز بدون پوست","amount":"۱۰۰ گرم","household":"۱ عدد کوچک"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"چهارپنجم لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره بادام‌زمینی، موز و شیر — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 18,
    'breakfast:9:نان،-کره-بادامزمینی،-موز-و-شیر:450', '[{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"کره بادام‌زمینی","amount":"۱۵ گرم","household":"۱ قاشق غذاخوری سرصاف"},{"name":"موز بدون پوست","amount":"۱۰۰ گرم","household":"۱ عدد کوچک"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"چهارپنجم لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: نان، کره و عسل با شیر (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('نان، کره و عسل با شیر', 'compound', 'breakfast', NULL, 'breakfast:10:نان،-کره-و-عسل-با-شیر', 'نکته: این گزینه نسبت به صبحانه‌های تخم‌مرغی پروتئین کمتری دارد؛ هم‌کالری‌بودن به معنی هم‌پروتئین‌بودن نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره و عسل با شیر — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 13,
    'breakfast:10:نان،-کره-و-عسل-با-شیر:350', '[{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"کره","amount":"۱۰ گرم","household":"۲ قاشق چای‌خوری سرصاف"},{"name":"عسل","amount":"۱۵ گرم","household":"۲ قاشق چای‌خوری"},{"name":"شیر کم‌چرب","amount":"۲۵۰ میلی‌لیتر","household":"۱ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 14g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره و عسل با شیر — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 14,
    'breakfast:10:نان،-کره-و-عسل-با-شیر:400', '[{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"کره","amount":"۱۰ گرم","household":"۲ قاشق چای‌خوری سرصاف"},{"name":"عسل","amount":"۱۵ گرم","household":"۲ قاشق چای‌خوری"},{"name":"شیر کم‌چرب","amount":"۲۵۰ میلی‌لیتر","household":"۱ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، کره و عسل با شیر — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 16,
    'breakfast:10:نان،-کره-و-عسل-با-شیر:450', '[{"name":"نان","amount":"۸۵ گرم","household":"حدود ۳ کف دست"},{"name":"کره","amount":"۱۰ گرم","household":"۲ قاشق چای‌خوری سرصاف"},{"name":"عسل","amount":"۱۵ گرم","household":"۲ قاشق چای‌خوری"},{"name":"شیر کم‌چرب","amount":"۲۵۰ میلی‌لیتر","household":"۱ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
