DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: ماست و موز و جو دوسر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست و موز و جو دوسر', 'compound', 'snack', 'filling', 'snack:16:ماست-و-موز-و-جو-دوسر', 'ماست سادهٔ کم‌چرب، موز بدون پوست و جو دوسر خشک؛ بدون عسل، شکر و مغزها. وزن جو دوسر پیش از خیساندن و وزن موز بدون پوست است. تمام مواد نوشته‌شده در کالری و پروتئین همان نسخه حساب شده‌اند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 6g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و موز و جو دوسر — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 6,
    'snack:16:ماست-و-موز-و-جو-دوسر:150', '[{"name":"ماست کم‌چرب","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"موز","amount":"۵۵ گرم","household":"حدود نصف یک موز کوچک"},{"name":"جو دوسر خشک","amount":"۱۰ گرم","household":"۲ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و موز و جو دوسر — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 10,
    'snack:16:ماست-و-موز-و-جو-دوسر:200', '[{"name":"ماست کم‌چرب","amount":"۱۵۰ گرم","household":"۱۰ قاشق غذاخوری سرصاف"},{"name":"موز","amount":"۶۰ گرم","household":"نصف یک موز متوسط"},{"name":"جو دوسر خشک","amount":"۱۵ گرم","household":"۳ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و موز و جو دوسر — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 12,
    'snack:16:ماست-و-موز-و-جو-دوسر:250', '[{"name":"ماست کم‌چرب","amount":"۲۰۰ گرم","household":"۱۳ قاشق غذاخوری سرصاف"},{"name":"موز","amount":"۸۰ گرم","household":"حدود ⅔ یک موز متوسط"},{"name":"جو دوسر خشک","amount":"۱۵ گرم","household":"۳ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;

