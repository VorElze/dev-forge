import importlib.util
import unittest
from pathlib import Path

PLUGIN = Path(__file__).parents[1] / "plugins" / "dev-forge-trigger" / "__init__.py"
spec = importlib.util.spec_from_file_location("dev_forge_trigger", PLUGIN)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

class TriggerTests(unittest.TestCase):
    def test_slash_only_at_start(self):
        self.assertEqual(module.match("/dev-forge build a site"), "/dev-forge")
        self.assertIsNone(module.match("please use /dev-forge later"))
    def test_build_phrases_case_insensitive(self):
        self.assertEqual(module.match("Saya ingin membuat aplikasi kasir"), "membuat aplikasi")
        self.assertEqual(module.match("BUILD A WEBSITE"), "build a website")
    def test_unrelated_message_does_not_trigger(self):
        self.assertIsNone(module.match("halo, apa kabar?"))
    def test_hook_payload_and_noop(self):
        self.assertIn("brief/spec/plan", module._on_pre_llm_call(user_message="/dev-forge")['context'])
        self.assertIsNone(module._on_pre_llm_call(user_message="hello"))

if __name__ == "__main__":
    unittest.main()
