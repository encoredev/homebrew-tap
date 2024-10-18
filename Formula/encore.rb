class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.42.1"
    checksums = {
        "darwin_arm64" => "ab745eeb690d67e5e10490f8ef2a15dcc5a503295bfc5e972c1f165927f215a7",
        "darwin_amd64" => "f88c9ee17bf1c2b78a0d2e737f84611ae760a8a423e6416e75fde7412ff37e41",
        "linux_arm64"  => "a1753fb346bcc0fd2c0d2fe9dbe585180890d4c1fb595702bb89b9cda432eef7",
        "linux_amd64"  => "2d4174e625691b42e52dbf2cef6457f0b28dedf7fdaf4c4c54d0e5745d151885",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
