class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230611"
    checksums = {
        "darwin_arm64" => "31947e6acc9adbc8ce6ac1bba745e3caf0c695e49ccade7828fd89db198fca51",
        "darwin_amd64" => "4d85d0f41e37c676ab6b99a49ab761ce8fb9e8e5aeb259037ca3c04d4bb1fd36",
        "linux_arm64"  => "5b5d9ebe977235a76a873076b267cde82cb4545c56df6d1dfbbd1fb6e3a6477b",
        "linux_amd64"  => "349c365619de4d40f0e371c1bcfa03c3fa764e0106520233a99ca1eaaec16abc",
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
