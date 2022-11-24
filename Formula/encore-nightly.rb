class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221124"
    checksums = {
        "darwin_arm64" => "350430bb10b20a41e29c498bf1677561243902c1e595cae7f86cca524f695067",
        "darwin_amd64" => "10f0a1b4975af25a12f56bdcfa8ce030aa9289ae3fe4f894239ab6d024b4901b",
        "linux_arm64"  => "d603aeef47ee303a52ee8704bbfb2094c44216cfa6d3bc0b20bed73e6472a67d",
        "linux_amd64"  => "d0fb8c62122b38241504b7a7e3d4dd46c7e5266efcb742bfa89b930bf654755e",
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
