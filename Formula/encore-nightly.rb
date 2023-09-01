class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230901"
    checksums = {
        "darwin_arm64" => "a4404befcff4b05cdd6d3ef90588a6d96bfe1a6613341d69a050df057845c08f",
        "darwin_amd64" => "f0e797d639b8af920837dee9cd804185567851333b00e68cf5a87436e694f769",
        "linux_arm64"  => "6cc646fc288b5a030c5acf766f0b599b9b94af52ce20ec32db256743aa168c7c",
        "linux_amd64"  => "bf7b55da7e3a296cf988c97f82fb2c9dafaa4fc309b27cc8bc2823bf321f6124",
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
