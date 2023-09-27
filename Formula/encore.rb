class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.27.0"
    checksums = {
        "darwin_arm64" => "53608e4dd2a69d920a70705de6d982f364b17017f1fef6a8950acccc06208bbd",
        "darwin_amd64" => "8c89da2b1dc60c1d32d5adda88fb06a5dabe4099a2866969acad567a06ac4741",
        "linux_arm64"  => "268f8adcf1420ddf2860723fdd4285a81f8f1315b56714ef14378e72fc2d7f39",
        "linux_amd64"  => "2b8f356f0f97d2e80c6a17f366ec075a0ec89846b19243985086f21d4067c553",
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
