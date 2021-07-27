# What to Use Jenkins for and When to Use It

Use Jenkins to automate your development workflow so you can focus on work that matters most. Jenkins is commonly used for:

 - Building projects
 - Running tests to detect bugs and other issues as soon as they are introduced
 - Static code analysis
 - Deployment


echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

echo 'Defaults:jenkins !requiretty' >> /etc/sudoers

setenforce 0 # Else disable SELINUX in /etc/sysconfig/selinux  and reboot

chown -R jenkins:jenkins /var/lib/jenkins 
chown -R jenkins:jenkins /var/cache/jenkins
chown -R jenkins:jenkins /var/log/jenkins

sudo nano /etc/default/jenkins

JENKINS_USER = jenkins
