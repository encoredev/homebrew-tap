class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231013"
    checksums = {
        "darwin_arm64" => "c428d02ad0bb5e8d8b442c5a9955109badf8e9680b749fbc6ff312966995ac91",
        "darwin_amd64" => "0ddc0349d875ffcd1a42734e4e0aae124b9eff52e6640da4284eda2f197ddb7a",
        "linux_arm64"  => "fb2aed0f687613251fea1339b57a8b81ffd8e052531cd38f7b5c0195175d3dba",
        "linux_amd64"  => "ca1e40280ed8ac752bbae644c644398901b4e957ac80f4780574d90e35741cc9",
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
