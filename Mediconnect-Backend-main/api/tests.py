# users/tests/test_views.py
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient
from django.test import TestCase
from .models import User, Patient

class UserModelTests(TestCase):
    def setUp(self):
        # Create a user instance
        self.user = User.objects.create(
            Username='testuser',
            Role='Patient',
            Email='test@example.com',
            Password='password123',
            NIC='123456789V',
            Device_ID='device_1',
            Birthday='1990-01-01',
            First_name='Test',
            Last_name='User',
        )

    def test_user_creation(self):
        # Verify that the user is created successfully
        self.assertIsInstance(self.user, User)
        self.assertEqual(self.user.Username, 'testuser')
        self.assertEqual(self.user.Role, 'Patient')
        self.assertEqual(self.user.Email, 'test@example.com')
        self.assertEqual(self.user.NIC, '123456789V')
        self.assertEqual(self.user.Device_ID, 'device_1')
        self.assertEqual(str(self.user.Birthday), '1990-01-01')
        self.assertEqual(self.user.First_name, 'Test')
        self.assertEqual(self.user.Last_name, 'User')


    def test_user_update(self):
        # Update user details
        self.user.Username = 'newuser'
        self.user.save()
        self.assertEqual(self.user.Username, 'newuser')

    def test_user_deletion(self):
        # Delete the user
        self.user.delete()
        self.assertEqual(User.objects.count(), 0)

class PatientModelTests(TestCase):
    def setUp(self):
        # Create a user instance
        self.user = User.objects.create(
            Username='testuser',
            Role='Patient',
            Email='test@email.com',
            Password='password123',
            NIC='123456789V',
            Device_ID='device_1',
            Birthday='1990-01-01',
            First_name='Test',
            Last_name='User',
        )
        # Create a patient instance
        self.patient = Patient.objects.create(
            User_ID=self.user,
            Breakfast_time='08:00:00',
            Lunch_time='12:00:00',
            Dinner_time='18:00:00',
        )

    def test_patient_creation(self):
        # Verify that the patient is created successfully
        self.assertIsInstance(self.patient, Patient)
        self.assertEqual(self.patient.User_ID, self.user)
        self.assertEqual(str(self.patient.Breakfast_time), '08:00:00')
        self.assertEqual(str(self.patient.Lunch_time), '12:00:00')
        self.assertEqual(str(self.patient.Dinner_time), '18:00:00')

    def test_patient_update(self):
        # Update patient details
        self.patient.Breakfast_time = '07:00:00'
        self.patient.save()
        self.assertEqual(str(self.patient.Breakfast_time), '07:00:00')

    def test_patient_deletion(self):
        # Delete the patient
        self.patient.delete()
        self.assertEqual(Patient.objects.count(), 0)





