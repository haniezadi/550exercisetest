DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

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

END $$;
