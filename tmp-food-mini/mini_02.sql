DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

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

END $$;
