class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231006"
    checksums = {
        "darwin_arm64" => "ccb1c03e245b5f3b7810288ed944ef12deafd058713187ee392a618b9f1e5b35",
        "darwin_amd64" => "d72e7cca9bf2723e30105c389706703649bf4b09f56fb7ceefc080330a45d96e",
        "linux_arm64"  => "39a3c2a81458120cd70cf1c6c42c27c3bb613d87ff08ab4091765e25201c5585",
        "linux_amd64"  => "1257de59236b02b472d5bb29203874607340f89dbea7e16cf760f0943b5f734b",
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
